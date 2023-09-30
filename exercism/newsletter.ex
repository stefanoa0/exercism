defmodule Newsletter do
  def read_emails(path) do
    {:ok, emails} = File.read(path)
    case String.trim(emails) do
      "" -> []
      emails -> String.split(emails, "\n")
    end
  end

  def open_log(path) do
    case File.open(path) |> IO.inspect() do
      {:ok, pid} -> pid
      {:error, error} -> nil
    end
  end

  def log_sent_email(pid, email) do
    File.write(pid, email)
  end

  def close_log(pid) do
    # Please implement the close_log/1 function
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    # Please implement the send_newsletter/3 function
  end
end
