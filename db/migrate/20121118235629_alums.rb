class Alums < ActiveRecord::Migration
  def up
  	create_table :alums do |t|
		t.column :first_major, :string
		t.column :second_major, :string
		t.column :third_major, :string
		t.column :first_minor, :string
		t.column :second_minor, :string
		t.column :third_minor, :string
		t.column :first_cert, :string
		t.column :second_cert, :string
		t.column :third_cert, :string
		t.column :location, :string
		t.column :industry, :string
		t.column :company, :string
		t.column :salary, :integer
		t.column :grad_year, :integer
		t.column :gpa, :double
		t.column :created_at, :timestamp
    end
  end

  def down
  	drop_table :alums
  end
end

