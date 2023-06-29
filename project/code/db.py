import pyodbc
import tkinter as tk
from tkinter import *
from tkinter import messagebox

conn = pyodbc.connect(
    'DRIVER={SQL Server};'
    'SERVER=DESKTOP-P0M7PIM;'
    'DATABASE=ChainRestaurant;'
    'Trusted_Connection=yes;'
)

def execute_query(query):
    try:
        cursor = conn.cursor()
        cursor.execute(query)
        conn.commit()
        messagebox.showinfo("Success", "Query executed successfully.")
    except pyodbc.Error as e:
        conn.rollback()
        messagebox.showerror("Error", str(e))


def insert_restaurant():
    rId = rId_entry.get()
    rName = rName_entry.get()
    rMail = rMail_entry.get()
    rWebsite = rWebsite_entry.get()
    rDetails = rDetails_entry.get()
    rAddress = rAddress_entry.get()
    rPhone = rPhone_entry.get()

    query = f"INSERT INTO Restaurant (rId, rName, rMail, rWebsite, rDetails, rAddress, rPhone) " \
            f"VALUES ({rId}, '{rName}', '{rMail}', '{rWebsite}', '{rDetails}', '{rAddress}', '{rPhone}')"

    execute_query(query)


def insert_ingredient():
    inId = inId_entry.get()
    inName = inName_entry.get()
    inAmount = inAmount_entry.get()
    inPrice = inPrice_entry.get()
    inDetails = inDetails_entry.get()
    inBuyer = inBuyer_entry.get()

    query = f"INSERT INTO Ingredient (inId, inName, inAmount, inPrice, inDetails, inBuyer) " \
            f"VALUES ({inId}, '{inName}', {inAmount}, {inPrice}, '{inDetails}', '{inBuyer}')"

    execute_query(query)


def delete_record():
    table_name = delete_table_var.get()
    record_id = delete_id_entry.get()
    if table_name == "Restaurant" or table_name == "restaurant":
        query = f"DELETE FROM {table_name} WHERE rId = {record_id}"
    elif table_name == "Ingredient" or table_name == "ingredient":
        query = f"DELETE FROM {table_name} WHERE inId = {record_id}"

    execute_query(query)


def update_record():
    table_name = update_table_var.get()
    record_id = update_id_entry.get()
    column_name = update_column_var.get()
    new_value = update_value_entry.get()
    if table_name == "Restaurant" or table_name == "restaurant":
        query = f"UPDATE {table_name} SET {column_name} = '{new_value}' WHERE rId = {record_id}"
    elif table_name == "Ingredient" or table_name == "ingredient":
        query = f"UPDATE {table_name} SET {column_name} = '{new_value}' WHERE inId = {record_id}"

    execute_query(query)


def show_all_entries():
    table_name = ""
    if selected_table.get() == 1:
        table_name = "Restaurant"
    elif selected_table.get() == 2:
        table_name = "Ingredient"
    else:
        messagebox.showerror("Error", "Please select a table.")
        return

    query = f"SELECT * FROM {table_name}"
    try:
        cursor = conn.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()
        if rows:
            messagebox.showinfo("Entries", "\n".join(str(row) for row in rows))
        else:
            messagebox.showinfo("Entries", "No entries found.")
    except pyodbc.Error as e:
        messagebox.showerror("Error", str(e))


window = tk.Tk()

scrollable_frame = tk.Frame(window)
scrollable_frame.pack(fill="both", expand=True)

canvas = tk.Canvas(scrollable_frame)
canvas.pack(side="left", fill="both", expand=True)

scrollbar = tk.Scrollbar(scrollable_frame, command=canvas.yview)
scrollbar.pack(side="right", fill="y")

canvas.configure(yscrollcommand=scrollbar.set)

inner_frame = tk.Frame(canvas)

canvas.create_window((0, 0), window=inner_frame, anchor="nw")

inner_frame.bind("<Configure>", lambda event: canvas.configure(scrollregion=canvas.bbox("all")))

restaurant_frame = tk.LabelFrame(inner_frame, text="Insert into Restaurant")
restaurant_frame.pack(padx=10, pady=10)

rId_label = tk.Label(restaurant_frame, text="rId:")
rId_label.grid(row=0, column=0)
rId_entry = tk.Entry(restaurant_frame)
rId_entry.grid(row=0, column=1)

rName_label = tk.Label(restaurant_frame, text="rName:")
rName_label.grid(row=1, column=0)
rName_entry = tk.Entry(restaurant_frame)
rName_entry.grid(row=1, column=1)

rMail_label = tk.Label(restaurant_frame, text="rMail:")
rMail_label.grid(row=2, column=0)
rMail_entry = tk.Entry(restaurant_frame)
rMail_entry.grid(row=2, column=1)

rWebsite_label = tk.Label(restaurant_frame, text="rWebsite:")
rWebsite_label.grid(row=3, column=0)
rWebsite_entry = tk.Entry(restaurant_frame)
rWebsite_entry.grid(row=3, column=1)

rDetails_label = tk.Label(restaurant_frame, text="rDetails:")
rDetails_label.grid(row=4, column=0)
rDetails_entry = tk.Entry(restaurant_frame)
rDetails_entry.grid(row=4, column=1)

rAddress_label = tk.Label(restaurant_frame, text="rAddress:")
rAddress_label.grid(row=5, column=0)
rAddress_entry = tk.Entry(restaurant_frame)
rAddress_entry.grid(row=5, column=1)

rPhone_label = tk.Label(restaurant_frame, text="rPhone:")
rPhone_label.grid(row=2, column=0)
rPhone_entry = tk.Entry(restaurant_frame)
rPhone_entry.grid(row=2, column=1)

insert_restaurant_button = Button(restaurant_frame, text="Insert", command=insert_restaurant)
insert_restaurant_button.grid(row=7, columnspan=2, pady=10)

ingredient_frame = LabelFrame(inner_frame, text="Insert into Ingredient")
ingredient_frame.pack(padx=10, pady=10)

inId_label = Label(ingredient_frame, text="inId:")
inId_label.grid(row=0, column=0)
inId_entry = Entry(ingredient_frame)
inId_entry.grid(row=0, column=1)

inName_label = Label(ingredient_frame, text="inName:")
inName_label.grid(row=1, column=0)
inName_entry = Entry(ingredient_frame)
inName_entry.grid(row=1, column=1)

inAmount_label = Label(ingredient_frame, text="inAmount:")
inAmount_label.grid(row=2, column=0)
inAmount_entry = Entry(ingredient_frame)
inAmount_entry.grid(row=2, column=1)

inPrice_label = Label(ingredient_frame, text="inPrice:")
inPrice_label.grid(row=3, column=0)
inPrice_entry = Entry(ingredient_frame)
inPrice_entry.grid(row=3, column=1)

inDetails_label = Label(ingredient_frame, text="inDetails:")
inDetails_label.grid(row=4, column=0)
inDetails_entry = Entry(ingredient_frame)
inDetails_entry.grid(row=4, column=1)

inBuyer_label = Label(ingredient_frame, text="inBuyer:")
inBuyer_label.grid(row=5, column=0)
inBuyer_entry = Entry(ingredient_frame)
inBuyer_entry.grid(row=5, column=1)

insert_ingredient_button = Button(ingredient_frame, text="Insert", command=insert_ingredient)
insert_ingredient_button.grid(row=6, columnspan=2, pady=10)

table_selection_frame = LabelFrame(inner_frame, text="Table Selection")
table_selection_frame.pack(padx=10, pady=10)

selected_table = tk.IntVar()

restaurant_checkbox = Checkbutton(table_selection_frame, text="Restaurant", variable=selected_table, onvalue=1,
                                  offvalue=0)
restaurant_checkbox.pack(anchor='w')

ingredient_checkbox = Checkbutton(table_selection_frame, text="Ingredient", variable=selected_table, onvalue=2,
                                  offvalue=0)
ingredient_checkbox.pack(anchor='w')

show_entries_button = Button(inner_frame, text="Show All Entries", command=show_all_entries)
show_entries_button.pack(pady=10)

delete_frame = LabelFrame(inner_frame, text="Delete Record")
delete_frame.pack(padx=10, pady=10)

delete_table_label = tk.Label(delete_frame, text="Table:")
delete_table_label.grid(row=0, column=0)
delete_table_var = tk.StringVar(delete_frame)
delete_table_var.set("Restaurant")
delete_table_options = ["Restaurant", "Ingredient"]
delete_table_menu = tk.OptionMenu(delete_frame, delete_table_var, *delete_table_options)
delete_table_menu.grid(row=0, column=1)

delete_id_label = tk.Label(delete_frame, text="Record ID:")
delete_id_label.grid(row=1, column=0)
delete_id_entry = tk.Entry(delete_frame)
delete_id_entry.grid(row=1, column=1)

delete_button = tk.Button(delete_frame, text="Delete", command=delete_record)
delete_button.grid(row=2, columnspan=2, pady=10)

update_frame = tk.LabelFrame(inner_frame, text="Update Record")
update_frame.pack(padx=10, pady=10)


update_table_label = tk.Label(update_frame, text="Table:")
update_table_label.grid(row=0, column=0)
update_table_var = tk.StringVar(update_frame)
update_table_var.set("Restaurant")
update_table_options = ["Restaurant", "Ingredient"]
update_table_menu = tk.OptionMenu(update_frame, update_table_var, *update_table_options)
update_table_menu.grid(row=0, column=1)

update_id_label = tk.Label(update_frame, text="Record ID:")
update_id_label.grid(row=1, column=0)
update_id_entry = tk.Entry(update_frame)
update_id_entry.grid(row=1, column=1)

update_column_label = tk.Label(update_frame, text="Column:")
update_column_label.grid(row=2, column=0)
update_column_var = tk.StringVar(update_frame)
update_column_var.set("rName")
update_column_options = ["rName", "rMail", "rWebsite", "rDetails", "rAddress", "rPhone"]
update_column_menu = tk.OptionMenu(update_frame, update_column_var, *update_column_options)
update_column_menu.grid(row=2, column=1)

update_value_label = tk.Label(update_frame, text="New Value:")
update_value_label.grid(row=3, column=0)
update_value_entry = tk.Entry(update_frame)
update_value_entry.grid(row=3, column=1)

update_button = tk.Button(update_frame, text="Update", command=update_record)
update_button.grid(row=4, columnspan=2, pady=10)

window.mainloop()
