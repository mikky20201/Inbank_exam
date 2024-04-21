import pandas as pd
from datetime import datetime

# Read data from Saturday and Sunday CSV files
saturday_df = pd.read_csv('data_2023-02-11.csv', delimiter=';')
sunday_df = pd.read_csv('data_2023-02-12.csv', delimiter=';')

# Combine data into one DataFrame
combined_data_df = pd.concat([saturday_df, sunday_df], ignore_index=True)

# Add a column for the generation date
combined_data_df['Generation Date'] = datetime.now().strftime('%Y-%m-%d')

# Save the combined data to a new CSV file
combined_data_df.to_csv('combined_data.csv', index=False, sep=';')

print("Successfully, combined data saved as 'combined_data.csv'")