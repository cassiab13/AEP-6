import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import os
import joblib

def verify_url_ml(url):
    has_https = 1 if url.startswith('https://') else 0
    has_http = 1 if url.startswith('http://') else 0
    tld_com = 1 if url.endswith('.com') else 0
    tld_net = 1 if url.endswith('.net') else 0
    tld_org = 1 if url.endswith('.org') else 0
    tld_io = 1 if url.endswith('.io') else 0
    tld_gov = 1 if url.endswith('.gov') else 0
    tld_edu = 1 if url.endswith('.edu') else 0
    length_url = 1 if len(url) < 100 else 0
    dot_count = 1 if url.count('.') < 5 else 0
    
    insecure_key_words = ['mal', 'fake', 'danger', 'fals', 'phish', 'login', 'verify', 'support', 'suspic']
    has_insecure_key_words = any(word in url.lower() for word in insecure_key_words)

    return [has_https, has_http, tld_com, tld_net, tld_org, tld_io, tld_gov, tld_edu, length_url, dot_count, has_insecure_key_words]

def prepare_data(df):
    attributes = []
    for url in df['url']:
        attributes.append(verify_url_ml(url))
    attributes_df = pd.DataFrame(attributes, columns=[
        'has_https', 'has_http', 'tld_com', 'tld_net', 'tld_org', 'tld_io', 'tld_gov', 'tld_edu', 'length_url', 'dot_count', 'has_insecure_key_words'
    ])
    return pd.concat([df, attributes_df], axis=1)

def load_data(filepath):
    return pd.read_csv(filepath)

def train_model(df):
    df_attributes = prepare_data(df)
    X = df_attributes[['has_https', 'has_http', 'tld_com', 'tld_net', 'tld_org', 'tld_io', 'tld_gov', 'tld_edu', 'length_url', 'dot_count', 'has_insecure_key_words']]
    y = df_attributes['label']
    
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)
    
    model_rf = RandomForestClassifier(n_estimators=100, random_state=42)
    model_rf.fit(X_train, y_train)
    
    y_pred = model_rf.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Random Forest Accuracy: {accuracy:.2f}")
    
    return model_rf

def predict_url(model, url):
    attributes = verify_url_ml(url)
    attribute_df = pd.DataFrame([attributes], columns=[
        'has_https', 'has_http', 'tld_com', 'tld_net', 'tld_org', 'tld_io', 
        'tld_gov', 'tld_edu', 'length_url', 'dot_count', 'has_insecure_key_words'
    ])
    
    prediction = model.predict(attribute_df)
    return "maliciosa" if prediction[0] == 0 else "segura"

csv_file_path = os.path.join(os.path.dirname(__file__),'example_urls.csv')
data = load_data(csv_file_path)
model = train_model(data)

joblib.dump(model, 'random_forest.pkl')