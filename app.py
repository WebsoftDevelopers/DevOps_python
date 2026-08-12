import os
import sys
from google import genai
from google.genai import types

def generate_ai_response(prompt: str) -> None:
    # Initialize the client (automatically reads GEMINI_API_KEY from environment)
    client = genai.Client()

    # Configure optional parameters like system instructions or temperature
    config = types.GenerateContentConfig(
        temperature=0.7,
        system_instruction="You are a helpful and concise DevOps assistant."
    )

    print(" Sending prompt to Gemini...")
    
    # Generate content using Gemini 2.5 Flash
    response = client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt,
        config=config,
    )

    print("\n--- Model Response ---")
    print(response.text)
    print("----------------------")

if __name__ == "__main__":
    # Accept prompt from command-line argument OR interactive fallback
    if len(sys.argv) > 1:
        user_prompt = " ".join(sys.argv[1:])
    else:
        user_prompt = input("Enter your prompt: ")

    generate_ai_response(user_prompt)