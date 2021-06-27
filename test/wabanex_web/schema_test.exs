defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn}do
      params = %{email: "joselito04@666.com", name: "Joselito 04", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

        expected_response = %{
          "data" => %{
            "getUser" => %{
              "email" => "joselito04@666.com",
              "name" => "Joselito 04"
            }
          }
        }

        assert response ==  expected_response
    end
  end
  describe "users mutations"do
    test "when all params are valid, created the user", %{conn: conn} do

      mutation = """
      mutation {
        createUser(input: {
          name: "Joselito 02", email: "joselito03@666.com", password: "123456"
        }){
          id
          name
        }
      }
      """

      response =
        conn
        |>post("/api/graphql", %{query: mutation})
        |>json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Joselito 02"}}} = response
    end
  end
end
