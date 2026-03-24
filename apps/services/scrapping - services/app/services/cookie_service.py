# services/cookie_service.py
from playwright.sync_api import sync_playwright
import requests as req
import json
import re

COOKIES_PATH = "app/google_cookies.json"


def get_current_popularity_via_browser(place_name, city="Maringá"):
    try:
        with sync_playwright() as p:
            browser = p.chromium.connect_over_cdp("http://localhost:9222")
            context = browser.contexts[0]
            page = context.new_page()

            query = f"{place_name} {city}"
            url = f"https://www.google.com/search?q={req.utils.quote(query)}&hl=pt-BR&gl=br"

            page.goto(url, wait_until="domcontentloaded", timeout=20000)
            page.wait_for_timeout(3000)

            content = page.content()
            page.close()

            barras = re.findall(r'height: ([\d.]+)px;.*?class="iUuOoc ([^"]*)"', content)

            if not barras:
                return None

            altura_max = max(float(h) for h, c in barras)
            barras_vermelhas = [(float(h), c) for h, c in barras if "Py9Hme" in c]

            if not barras_vermelhas:
                return None

            altura_atual = barras_vermelhas[0][0]
            popularidade = round((1 - altura_atual / altura_max) * 100)
            return max(0, min(100, popularidade))

    except Exception as e:
        print(f"  [ERRO browser] {place_name}: {e}")
        return None