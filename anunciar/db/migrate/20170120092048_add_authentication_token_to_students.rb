class AddAuthenticationTokenToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :authentication_token, :string
  end
end
