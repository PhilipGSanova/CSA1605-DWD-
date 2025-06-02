import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

plt.style.use('ggplot')

import nltk
# Ensure the necessary NLTK data is downloaded
nltk.download('punkt')
nltk.download('punkt_tab') # Download the punkt_tab resource
nltk.download('averaged_perceptron_tagger') # Download the POS tagger
# Download the specific language resource for the tagger
nltk.download('averaged_perceptron_tagger_eng')
# Download the named entity chunker resource
nltk.download('maxent_ne_chunker_tab')
# Download the 'words' corpus which is needed for ne_chunk
nltk.download('words')

# Read in data
df = pd.read_csv('/content/drive/MyDrive/Reviews.csv')
print(df.shape)
df = df.head(500)
print(df.shape)

df.head()

ax = df['Score'].value_counts().sort_index() \
    .plot(kind='bar',
          title='Count of Reviews by Stars',
          figsize=(10, 5))
ax.set_xlabel('Review Stars')
plt.show()

example = df['Text'][50]
print(example)

tokens = nltk.word_tokenize(example)
tokens[:10]

tagged = nltk.pos_tag(tokens)
tagged[:10]

entities = nltk.chunk.ne_chunk(tagged)
entities.pprint()

from nltk.sentiment import SentimentIntensityAnalyzer
from tqdm.notebook import tqdm
import nltk # Ensure nltk is imported here as well

# Download the VADER lexicon
nltk.download('vader_lexicon')

sia = SentimentIntensityAnalyzer()

sia.polarity_scores('I am so happy!')

sia.polarity_scores('This is the worst thing ever.')

sia.polarity_scores('This is the worst thing ever.')

# Run the polarity score on the entire dataset
res = {}
for i, row in tqdm(df.iterrows(), total=len(df)):
    text = row['Text']
    myid = row['Id']
    res[myid] = sia.polarity_scores(text)

vaders = pd.DataFrame(res).T
vaders = vaders.reset_index().rename(columns={'index': 'Id'})
vaders = vaders.merge(df, how='left')

# Now we have sentiment score and metadata
vaders.head()

# @title pos

from matplotlib import pyplot as plt
vaders['pos'].plot(kind='hist', bins=20, title='pos')
plt.gca().spines[['top', 'right',]].set_visible(False)

# @title neu

from matplotlib import pyplot as plt
vaders['neu'].plot(kind='hist', bins=20, title='neu')
plt.gca().spines[['top', 'right',]].set_visible(False)

# @title neg

from matplotlib import pyplot as plt
vaders['neg'].plot(kind='hist', bins=20, title='neg')
plt.gca().spines[['top', 'right',]].set_visible(False)

ax = sns.barplot(data=vaders, x='Score', y='compound')
ax.set_title('Compund Score by Amazon Star Review')
plt.show()

fig, axs = plt.subplots(1, 3, figsize=(12, 3))
sns.barplot(data=vaders, x='Score', y='pos', ax=axs[0])
sns.barplot(data=vaders, x='Score', y='neu', ax=axs[1])
sns.barplot(data=vaders, x='Score', y='neg', ax=axs[2])
axs[0].set_title('Positive')
axs[1].set_title('Neutral')
axs[2].set_title('Negative')
plt.tight_layout()
plt.show()

from transformers import AutoTokenizer
from transformers import AutoModelForSequenceClassification
from scipy.special import SoftMax

MODEL = f"cardiffnlp/twitter-roberta-base-sentiment"
tokenizer = AutoTokenizer.from_pretrained(MODEL)
model = AutoModelForSequenceClassification.from_pretrained(MODEL)

# VADER results on example
print(example)
sia.polarity_scores(example)

# Run for Roberta Model
encoded_text = tokenizer(example, return_tensors='pt')
output = model(**encoded_text)
scores = output[0][0].detach().numpy()
scores = softmax(scores)
scores_dict = {
    'roberta_neg' : scores[0],
    'roberta_neu' : scores[1],
    'roberta_pos' : scores[2]
}
print(scores_dict)

def polarity_scores_roberta(example):
    encoded_text = tokenizer(example, return_tensors='pt')
    output = model(**encoded_text)
    scores = output[0][0].detach().numpy()
    scores = softmax(scores)
    scores_dict = {
        'roberta_neg' : scores[0],
        'roberta_neu' : scores[1],
        'roberta_pos' : scores[2]
    }
    return scores_dict

res = {}
for i, row in tqdm(df.iterrows(), total=len(df)):
    try:
        text = row['Text']
        myid = row['Id']
        vader_result = sia.polarity_scores(text)
        vader_result_rename = {}
        for key, value in vader_result.items():
            vader_result_rename[f"vader_{key}"] = value
        roberta_result = polarity_scores_roberta(text)
        both = {**vader_result_rename, **roberta_result}
        res[myid] = both
    except RuntimeError:
        print(f'Broke for id {myid}')

results_df = pd.DataFrame(res).T
results_df = results_df.reset_index().rename(columns={'index': 'Id'})
results_df = results_df.merge(df, how='left')

results_df.columns

sns.pairplot(data=results_df,
             vars=['vader_neg', 'vader_neu', 'vader_pos',
                  'roberta_neg', 'roberta_neu', 'roberta_pos'],
            hue='Score',
            palette='tab10')
plt.show()

results_df.query('Score == 1') \
    .sort_values('roberta_pos', ascending=False)['Text'].values[0]

results_df.query('Score == 1') \
    .sort_values('vader_pos', ascending=False)['Text'].values[0]

results_df.query('Score == 5') \
    .sort_values('roberta_neg', ascending=False)['Text'].values[0]

results_df.query('Score == 5') \
    .sort_values('vader_neg', ascending=False)['Text'].values[0]

from transformers import pipeline

sent_pipeline = pipeline("sentiment-analysis")

sent_pipeline('I love this product, it works so well!')
sent_pipeline('Very disappointed with the customer serivce today')

from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, confusion_matrix, classification_report

# Step 1: Map Amazon 'Score' to Sentiment Labels
def map_amazon_score_to_sentiment(score):
    if score in [1, 2]:
        return 'negative'
    elif score == 3:
        return 'neutral'
    else:  # 4 or 5
        return 'positive'

results_df['true_sentiment'] = results_df['Score'].apply(map_amazon_score_to_sentiment)

# Step 2: Get Predicted Sentiment from RoBERTa
def get_roberta_sentiment(row):
    scores = {
        'positive': row['roberta_pos'],
        'neutral': row['roberta_neu'],
        'negative': row['roberta_neg']
    }
    return max(scores, key=scores.get)

results_df['predicted_sentiment'] = results_df.apply(get_roberta_sentiment, axis=1)

# Step 3: Evaluation
y_true = results_df['true_sentiment']
y_pred = results_df['predicted_sentiment']

# Accuracy
# Renamed variable to have 'roberta_' prefix
roberta_accuracy = accuracy_score(y_true, y_pred)
print(f"Accuracy: {roberta_accuracy:.4f}")

# Precision, Recall, F1-Score (Macro for multi-class)
# Renamed variables to have 'roberta_' prefix
roberta_precision = precision_score(y_true, y_pred, average='macro')
roberta_recall = recall_score(y_true, y_pred, average='macro')
roberta_f1 = f1_score(y_true, y_pred, average='macro')

print(f"Precision: {roberta_precision:.4f}")
print(f"Recall:    {roberta_recall:.4f}")
print(f"F1-Score:  {roberta_f1:.4f}")

# Confusion Matrix
conf_mat = confusion_matrix(y_true, y_pred, labels=['negative', 'neutral', 'positive'])

print("\nConfusion Matrix:")
print(conf_mat)

# Optional: Detailed Classification Report
print("\nClassification Report:")
print(classification_report(y_true, y_pred))

# Step 1: Get Predicted Sentiment from VADER
def get_vader_sentiment(row):
    scores = {
        'positive': row['vader_pos'],
        'neutral': row['vader_neu'],
        'negative': row['vader_neg']
    }
    return max(scores, key=scores.get)

results_df['vader_predicted_sentiment'] = results_df.apply(get_vader_sentiment, axis=1)

# Step 2: Evaluation
y_true_vader = results_df['true_sentiment']
y_pred_vader = results_df['vader_predicted_sentiment']

# Accuracy
vader_accuracy = accuracy_score(y_true_vader, y_pred_vader)
print(f"VADER Accuracy: {vader_accuracy:.4f}")

# Precision, Recall, F1-Score
vader_precision = precision_score(y_true_vader, y_pred_vader, average='macro')
vader_recall = recall_score(y_true_vader, y_pred_vader, average='macro')
vader_f1 = f1_score(y_true_vader, y_pred_vader, average='macro')

print(f"VADER Precision: {vader_precision:.4f}")
print(f"VADER Recall:    {vader_recall:.4f}")
print(f"VADER F1-Score:  {vader_f1:.4f}")

# Confusion Matrix
vader_conf_mat = confusion_matrix(y_true_vader, y_pred_vader, labels=['negative', 'neutral', 'positive'])

print("\nVADER Confusion Matrix:")
print(vader_conf_mat)

# Classification Report
print("\nVADER Classification Report:")
print(classification_report(y_true_vader, y_pred_vader))

import pandas as pd

# Store the evaluation metrics for both models
metrics_comparison = {
    'Metric': ['Accuracy', 'Precision', 'Recall', 'F1-Score'],
    'VADER': [vader_accuracy, vader_precision, vader_recall, vader_f1],
    'RoBERTa': [roberta_accuracy, roberta_precision, roberta_recall, roberta_f1]
}

# Create a DataFrame for comparison
comparison_df = pd.DataFrame(metrics_comparison)

# Display the table
print("🔍 Comparison of VADER and RoBERTa Sentiment Analysis Models:")
print(comparison_df.to_string(index=False))

# Identify which model performed better for each metric
better_model = comparison_df[['VADER', 'RoBERTa']].apply(lambda row: 'VADER' if row['VADER'] > row['RoBERTa'] else 'RoBERTa', axis=1)
comparison_df['Better Model'] = better_model

print("\n📊 Model Performance Summary:")
print(comparison_df.to_string(index=False))

# Overall Better Model (based on F1-score as main metric)
overall_better = 'VADER' if vader_f1 > roberta_f1 else 'RoBERTa'
print(f"\n🏆 Overall Better Model (based on F1-Score): {overall_better}")
