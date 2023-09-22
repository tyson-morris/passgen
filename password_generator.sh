#!/bin/bash

# Function to generate a random password
generate_password() {
    local length="$1"
    local use_alphanumeric="$2"
    local password=""

    if [ "$use_alphanumeric" -eq 1 ]; then
        characters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    else
        characters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_-+=<>?{}[]"
    fi

    for (( i=0; i < length; i++ )); do
        random_index=$((RANDOM % ${#characters}))
        password="${password}${characters:$random_index:1}"
    done

    echo "$password"
}

# Get user input for password length
read -p "Enter the desired password length: " password_length

# Check if the input is a positive integer
if [[ ! "$password_length" =~ ^[1-9][0-9]*$ ]]; then
    echo "Invalid input. Please enter a positive integer for password length."
    exit 1
fi

# Ask if the user wants to include special characters
read -p "Include special characters (y/n)? " include_special

if [[ "$include_special" =~ ^[Yy] ]]; then
    use_special=1
else
    use_special=0
fi

# Generate and display the password
password=$(generate_password "$password_length" "$use_special")
echo "Generated Password: $password"
