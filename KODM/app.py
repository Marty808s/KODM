import pyodbc

drivers = pyodbc.drivers()
print(drivers)

conn_str = (
    'DRIVER={SQL Server};'
    'SERVER=localhost;'
    'DATABASE=MultidimensionalProject;'
    'UID=Marty;'
    'PWD=311'
)

conn = pyodbc.connect(conn_str)

if (conn):
    print("Logged in!")
else:
    print("Chyba!")