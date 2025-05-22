#!/bin/bash
echo "Running DB migrations (if needed)..."
python3 -c "from app import db; db.create_all()"
echo "Starting Flask app..."
exec python app.py
