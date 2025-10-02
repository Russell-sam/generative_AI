# Customer Support Chatbot (Jaseci / JAC)

##  Overview
This project implements a **customer support chatbot** using **Jaseci (JAC)** with integration to a Large Language Model (LLM).  
The chatbot automatically:
- Categorizes customer queries (Technical, Billing, or General)
- Analyzes sentiment (Positive, Neutral, Negative)
- Routes queries to the right response handler
- Escalates negative sentiment queries to human agents
- Provides interactive support in a terminal

---

##  Features
- **Query Categorization** → Classifies queries into **Technical**, **Billing**, or **General**  
- **Sentiment Analysis** → Detects whether the query tone is **Positive, Neutral, or Negative**  
- **Escalation Handling** → Automatically routes **negative queries** to human support  
- **Dynamic Responses** → Generates helpful, context-aware responses with LLMs  
- **Interactive CLI Mode** → Users can chat with the bot in real-time  

---

##  Tech Stack
- **[Jaseci](https://github.com/Jaseci-Labs/jaseci)** – Framework for building AI agents in JAC  
- **Groq LLM API** – Uses `groq/llama-3.3-70b-versatile` for categorization and responses  
- **Python 3.8+** – Required for running Jaseci and CLI mode  
- **byLLM** – Jaseci module for LLM-powered functions  

---


