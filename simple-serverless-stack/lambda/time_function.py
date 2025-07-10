import json
from datetime import datetime

def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps({
            "current_time": datetime.utcnow().isoformat()
        }),
        "headers": {
            "Content-Type": "application/json"
        }
    }
