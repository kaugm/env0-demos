import json

# AFTER EDING PLEASE RUN zip lambda_function_payload.zip app.py

def lambda_handler(event, context):
    """
    Processes a DynamoDB stream event.
    """
    print("Received event: " + json.dumps(event, indent=2))
    
    # Iterate over the records in the stream event
    for record in event['Records']:
        # Extract the event name (e.g., INSERT, MODIFY, REMOVE)
        event_name = record['eventName']
        print(f"Processing a {event_name} event.")
        
        # Check if the event contains new data
        if 'NewImage' in record['dynamodb']:
            new_image = record['dynamodb']['NewImage']
            # Access the 'id' of the new item
            item_id = new_image['id']['S']
            print(f"New item with ID: {item_id}")

    return {
        'statusCode': 200,
        'body': json.dumps('Processing complete!')
    }