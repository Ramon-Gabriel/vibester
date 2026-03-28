/*
import { Request, Response, NextFunction } from "express";
import { responseUtil } from "../utils/response.util";
import { AuthRequest } from "../middlewares/auth.middleware";
import { authService } from "../services/auth.service";

export const authController = {
    async register(req: Request, res: Response, next: NextFunction) {
        try {
            const result = await authService.register(req.body);
            return responseUtil.success(res, result, 201);
        } catch (err) {
            next(err);
        }
    }, 

    async login(req: Request, res: Response, next: NextFunction) {
        try {
            const result = await authService.login(req.body);
            return responseUtil.success(res, result);
        } catch (err) {
            next(err);
        }
    },

    async refreshToken(req: Request, res: Response, next: NextFunction) {
        try {
            const { refreshToken } = req.body;
            const result = await authService.refreshToken(refreshToken);
            return responseUtil.success(res, result);
        } catch (err) {
            next(err);
        }
    },

    async logout(req: AuthRequest, res: Response, next: NextFunction) {
        try {
            const user = await authService.logout(req.userId as string);
            return responseUtil.success(res, user);
        } catch (err) {
            next(err);
        }
    }
}
    */