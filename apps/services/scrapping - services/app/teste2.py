from database.connection import Database
from services.current_popularity_service import CurrentPopularityService

db = Database()
service = CurrentPopularityService()

db.cursor.execute("SELECT place_id, name FROM places")
lugares = db.cursor.fetchall()

print(f"Total de lugares no banco: {len(lugares)}\n")

com_dado = 0
sem_dado = 0
total_requisicoes = 0

for place_id, name in lugares:
    total_requisicoes += 1
    pop = service.get_current_popularity(name)

    if pop is not None:
        com_dado += 1
        if pop >= 70:
            status = "LOTADO"
        elif pop >= 40:
            status = "MODERADO"
        else:
            status = "TRANQUILO"
        print(f"  [{total_requisicoes}] [{status}] {name}: {pop}%")
    else:
        sem_dado += 1
        print(f"  [{total_requisicoes}] [SEM DADO] {name}")

print(f"\nTotal requisicoes: {total_requisicoes}")
print(f"Com dado: {com_dado}")
print(f"Sem dado: {sem_dado}")