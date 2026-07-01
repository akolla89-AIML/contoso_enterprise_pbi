| OLTP                         | OLAP                           |
| ---------------------------- | ------------------------------ |
| Optimized for transactions   | Optimized for analytics        |
| Highly normalized            | Denormalized where appropriate |
| Frequent inserts/updates     | Mostly reads                   |
| Supports business operations | Supports reporting and BI      |

Business Example

OLTP - Thousands of these records are created daily.
OrderID: 10001
Customer: John
Product: Laptop
Quantity: 1

OLAP - Instead of processing transactions individually, we ask questions like:
Sales by Month
Sales by Region
Top Products
Profit by Category

This is why we build a data warehouse.