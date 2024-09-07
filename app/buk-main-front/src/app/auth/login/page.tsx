import LoginForm from "./login.form";

export default function Page() {
  return (
    <>
      <div className="flex flex-col items-center justify-center mt-40">
        <h1>Hello</h1>

        <div className="w-[360px]">
          <LoginForm />
        </div>
      </div>
    </>
  )
}
