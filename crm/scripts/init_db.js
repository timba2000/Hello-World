const sqlite3 = require('sqlite3').verbose();
const fs = require('fs');

const db = new sqlite3.Database('crm/db/contacts.db');
const schema = fs.readFileSync('crm/db/schema.sql', 'utf8');

db.exec(schema, (err) => {
    if (err) {
        console.error('Error creating database:', err);
    } else {
        console.log('Database initialized successfully.');
    }
    db.close();
});
