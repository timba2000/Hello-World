
-- Schema for Personal CRM

CREATE TABLE IF NOT EXISTS contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    company TEXT,
    role TEXT,
    source TEXT, -- 'gmail', 'calendar', 'manual'
    first_seen_at DATETIME,
    last_interaction_at DATETIME,
    health_score INTEGER DEFAULT 50, -- 0-100
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS interactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    contact_id INTEGER,
    type TEXT, -- 'email_sent', 'email_received', 'meeting'
    summary TEXT,
    occurred_at DATETIME,
    source_id TEXT, -- email ID or event ID
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(contact_id) REFERENCES contacts(id)
);

CREATE TABLE IF NOT EXISTS embeddings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    entity_type TEXT, -- 'contact', 'interaction'
    entity_id INTEGER,
    vector BLOB, -- Vector data
    content_hash TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS reminders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    contact_id INTEGER,
    note TEXT,
    due_at DATETIME,
    status TEXT DEFAULT 'pending', -- 'pending', 'snoozed', 'done'
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
