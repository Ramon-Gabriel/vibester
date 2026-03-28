-- CreateTable
CREATE TABLE "accesses" (
    "id" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "accesses_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "accesses_accountId_key" ON "accesses"("accountId");

-- CreateIndex
CREATE UNIQUE INDEX "accesses_username_key" ON "accesses"("username");

-- CreateIndex
CREATE UNIQUE INDEX "accesses_email_key" ON "accesses"("email");
