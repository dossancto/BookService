'use server'

import { redirect } from "next/navigation"

export async function postLoginAction(): Promise<void> {
    redirect("/")
}

