import os
import psycopg
import csv
from dotenv import load_dotenv


load_dotenv()

connection = psycopg.connect(
    host="localhost",
    port=5433,
    dbname="ecommerce",
    user="de_user",
    password=os.getenv("POSTGRES_PASSWORD")
)

print("Successfully connected to PostgreSQL!")

cursor = connection.cursor()
cursor.execute("SELECT customer_id, name, country FROM customers;")

rows = cursor.fetchall()

for row in rows:
    print(row[0], row[1], row[2])



with open("data/customers_cleaned.csv", mode="r", encoding="utf-8", newline="") as file:
    reader = csv.DictReader(file)

    for row in reader:
        cursor.execute(
            """
            INSERT INTO customers_etl (customer_id, name, country, email)
            VALUES (%s, %s, %s, %s)
            ON CONFLICT (customer_id) DO NOTHING;
            """,
            (
                int(row["customer_id"]),
                row["name"],
                row["country"],
                row["email"]
            )
        )

connection.commit()

cursor.execute("SELECT COUNT(*) FROM customers_etl;")
customer_count = cursor.fetchone()[0]

assert customer_count == 5, "Expected 5 customers in PostgreSQL"
print(f"Valudation passed: {customer_count} customers in PostgreSQL")


cursor.close()

connection.close()
