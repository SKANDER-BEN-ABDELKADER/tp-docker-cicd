-- Create messages table
CREATE TABLE IF NOT EXISTS messages (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO messages (content) VALUES 
    ('Welcome to our Docker PostgreSQL app!'),
    ('This is a sample message from the database'),
    ('You can add your own messages too!')
ON CONFLICT DO NOTHING;