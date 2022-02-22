require 'pg'

p 'setting up test database'

conn = PG.connect(dbname: 'makersbnb_test')
conn.exec('TRUNCATE spaces;')
