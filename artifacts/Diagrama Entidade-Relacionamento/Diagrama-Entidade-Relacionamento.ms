erDiagram
    ACCESS {
        string id PK
        string accountId UK
        string username UK
        string email UK
        string passwordHash
        datetime createdAt
        datetime updatedAt
    }