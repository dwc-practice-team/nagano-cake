# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

Admin.create!(
  email: "admin@test.com",
  password: "password"
)

customers_attributes = [
  {
    last_name: "山田",
    first_name: "太郎",
    last_name_kana: "ヤマダ",
    first_name_kana: "タロウ",
    postal_code: "1234567",
    address: "東京都渋谷区渋谷2-43-21",
    telephone_number: "09012345678"
  },
  {
    last_name: "佐藤",
    first_name: "花子",
    last_name_kana: "サトウ",
    first_name_kana: "ハナコ",
    postal_code: "1234567",
    address: "東京都港区南青山5-12-34",
    telephone_number: "09012345678"
  },
  {
    last_name: "田中",
    first_name: "蒼",
    last_name_kana: "タナカ",
    first_name_kana: "アオイ",
    postal_code: "1234567",
    address: "大阪府大阪市中央区大手通2-12-34",
    telephone_number: "09012345678"
  },
  {
    last_name: "中村",
    first_name: "真",
    last_name_kana: "ナカムラ",
    first_name_kana: "マコト",
    postal_code: "1234567",
    address: "広島県広島市中区中町98-76",
    telephone_number: "09012345678"
  },
  {
    last_name: "鈴木",
    first_name: "晃",
    last_name_kana: "スズキ",
    first_name_kana: "アキラ",
    postal_code: "1234567",
    address: "福岡県福岡市博多区博多駅南4-56-78",
    telephone_number: "09012345678"
  },
  {
    last_name: "井上",
    first_name: "つかさ",
    last_name_kana: "イノウエ",
    first_name_kana: "ツカサ",
    postal_code: "1234567",
    address: "北海道札幌市中央区南2条西11-22-33",
    telephone_number: "09012345678"
  },
]

puts "#=> Customer start"

customers_attributes.each_with_index do |customer_attributes, index|
  Customer.create!(
    customer_attributes.merge(
      email: "test_#{index + 1}@test.com",
      password: "password"
    )
  )
end

puts "#=> Customer finished"

puts "seedの実行を完了"