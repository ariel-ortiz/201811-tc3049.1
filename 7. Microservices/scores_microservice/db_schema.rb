require 'sequel'

DB = Sequel.connect('sqlite://scores.db')

DB.drop_table? :scores

DB.create_table :scores do
  primary_key :id
  String      :initials
  Integer     :score
  DateTime    :timestamp
end
