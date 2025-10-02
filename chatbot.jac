import from byllm { Model }

# Initialize the LLM model
glob llm = Model(model_name="groq/llama-3.3-70b-versatile");

# Define enums for structured outputs
enum Category {
    TECHNICAL,
    BILLING,
    GENERAL
}

enum Sentiment {
    POSITIVE,
    NEUTRAL,
    NEGATIVE
}

# State structure using node
node State {
    has query: str;
    has category: Category;
    has sentiment: Sentiment;
    has response: str;
}

# LLM-powered functions for analysis
def categorize_query(query: str) -> Category by llm(
    instructions="Categorize the following customer query into one of these categories: "
    "Technical, Billing, or General. Return only the category name."
);

def analyze_sentiment_query(query: str) -> Sentiment by llm(
    instructions="Analyze the sentiment of the following customer query. "
    "Respond with either 'Positive', 'Neutral', or 'Negative'."
);

def handle_technical_query(query: str) -> str by llm(
    instructions="Provide a technical support response to the following query. "
    "Be helpful and provide troubleshooting steps."
);

def handle_billing_query(query: str) -> str by llm(
    instructions="Provide a billing support response to the following query. "
    "Be professional and address payment or invoice concerns."
);

def handle_general_query(query: str) -> str by llm(
    instructions="Provide a general support response to the following query. "
    "Be friendly and helpful."
);

# Main customer support function
def run_customer_support(query: str) -> dict {
    # Step 1: Categorize the query
    category = categorize_query(query);
    print(f"Category detected: {category}");
    
    # Step 2: Analyze sentiment
    sentiment = analyze_sentiment_query(query);
    print(f"Sentiment detected: {sentiment}");
    
    # Step 3: Route and handle based on sentiment and category
    response = "";
    
    if sentiment == Sentiment.NEGATIVE {
        response = "This query has been escalated to a human agent due to its negative sentiment.";
    } elif category == Category.TECHNICAL {
        response = handle_technical_query(query);
    } elif category == Category.BILLING {
        response = handle_billing_query(query);
    } else {
        response = handle_general_query(query);
    }
    
    return {
        "category": str(category),
        "sentiment": str(sentiment),
        "response": response
    };
}

# Entry point with test
with entry {
    print("=== Customer Support Chatbot ===\n");
    
    # Test query
    test_query = "My internet connection is gone it's not working, Can you help me?";
    
    print(f"Query: {test_query}\n");
    
    result = run_customer_support(test_query);
    
    print(f"\nCategory: {result['category']}");
    print(f"Sentiment: {result['sentiment']}");
    print(f"Response: {result['response']}");
    print("\n");
    
    # Interactive mode
    print("=== Interactive Mode ===");
    print("Type your support query (or 'quit' to exit):\n");
    
    while True {
        user_query = input("You: ");
        
        if user_query.lower() in ["quit", "exit"] {
            print("Thank you for using our support system!");
            break;
        }
        
        if not user_query.strip() {
            continue;
        }
        
        try {
            result = run_customer_support(user_query);
            print(f"\nBot: {result['response']}\n");
        } except Exception as e {
            print(f"Error: {e}");
        }
    }
}