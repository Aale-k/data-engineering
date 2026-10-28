import csv

cleaned_customers = []

with open("data/customers.csv", mode="r", encoding="utf-8", newline="") as file:
    reader = csv.DictReader(file)

    for row in reader:
        customer_id = int(row["customer_id"])
        assert customer_id > 0, "Customer ID must be positive"
        email = row["email"] or "Not provided"

        cleaned_customers.append({
            "customer_id": customer_id,
            "name": row["name"],
            "country": row["country"],
            "email": email})


assert len(cleaned_customers) == 5, "Expected 5 cleaned customer records"

customer_ids = [customer["customer_id"] for customer in cleaned_customers]
assert len(customer_ids) == len(set(customer_ids)), "Duplicate customer IDs detected"


with open("data/customers_cleaned.csv", mode="w", encoding="utf-8", newline="") as file:
    writer = csv.DictWriter(file, fieldnames=["customer_id","name","country","email"])
    writer.writeheader()
    writer.writerows(cleaned_customers)