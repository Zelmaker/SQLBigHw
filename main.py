import json

def get_json():
    with open("suppliers.json", encoding="UTF-8") as file:
        jsonfile = json.load(file)
        return jsonfile


def make_sql_file(data):
    with open('suppliers.sql', 'a', encoding='UTF-8') as file:
        table_suppliers = """CREATE TABLE IF NOT EXISTS suppliers(
    id INT PRIMARY KEY NOT NULL,
    company_name VARCHAR(50),
    contact_name VARCHAR(100),
    contact_title VARCHAR(100),
    country VARCHAR(50),
    region VARCHAR(50),
    post_code VARCHAR(50),
    city VARCHAR(50),
    address VARCHAR(225),
    phone VARCHAR(25),
    fax VARCHAR(25),
    homepage VARCHAR(225)
);\n"""

        file.write(table_suppliers)
        index = 1
        for d in data:
            d['id'] = index
            contact = d['contact'].split(', ')
            address = d['address'].split('; ')
            d['company_name'] = d['company_name'].replace("'", "''")
            address[4] = address[4].replace("'", "''")
            d['homepage'] = d['homepage'].replace("'", "''")
            request = f"""INSERT INTO suppliers VALUES ({d['id']}, '{d['company_name']}', '{contact[0]}', '{contact[1]}', '{address[0]}', '{address[1]}', '{address[2]}', '{address[3]}', '{address[4]}', '{d['phone']}', '{d['fax']}', '{d['homepage']}');\n"""
            index += 1
            file.write(request)

        update_table_prod_1 = """\nALTER TABLE products ADD COLUMN id_suppliers INT REFERENCES suppliers(id);\n\n"""
        file.write(update_table_prod_1)
        for d in data:
            product = [p.replace("'", "''") for p in d['products']]

            update_table_prod_2 = f"""UPDATE products SET id_suppliers = {d['id']} WHERE product_name IN ('{"', '".join(product)}');\n"""
            file.write(update_table_prod_2)



def main():
    data = get_json()
    make_sql_file(data)

if __name__ == '__main__':
    main()