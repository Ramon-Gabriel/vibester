export interface RegisterInputInterface {
    username: string;
    name: string;
    email: string;
    password: string;
    bornAt: Date;
}

export interface RegisterOutputInterface {
    id: string;
    // token: string;
    username: string;
    name: string;
    email: string;
    bornAt: Date;
    createdAt: Date;
    updatedAt: Date;
}