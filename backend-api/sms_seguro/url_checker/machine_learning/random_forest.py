import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import os
import joblib

def verify_url_ml(url):
    has_https = 0 if url.startswith('https://') else 1
    has_http = 1 if url.startswith('http://') else 0
    tld_com = 0 if url.endswith('.com') else 1
    tld_com_br = 0 if url.endswith('.com.br') else 1
    tld_net = 1 if '.net' in url else 0
    tld_org = 0 if '.org' in url else 1
    tld_io = 0 if url.endswith('.io') else 1
    tld_gov = 0 if '.gov' in url else 1
    tld_edu = 0 if '.edu' in url else 1
    length_url = 0 if len(url) < 100 else 1
    dot_count = 0 if url.count('.') < 5 else 1
    
    insecure_key_words = ['mal', 'fake', 'danger', 'fals', 'phish', 'login', 'verify', 'support', 'suspic']
    has_insecure_key_words = 0
    for word in insecure_key_words:
        if word in url.lower():
            has_insecure_key_words = 1
            break

    return [has_https, has_http, tld_com, tld_com_br, tld_net, tld_org, tld_io, tld_gov, tld_edu, length_url, dot_count, has_insecure_key_words]

def prepare_data(df):
    attributes = []
    for url in df['url']:
        attributes.append(verify_url_ml(url))
    attributes_df = pd.DataFrame(attributes, columns=[
        'has_https', 'has_http', 'tld_com', 'tld_com_br', 'tld_net', 'tld_org', 'tld_io', 'tld_gov', 'tld_edu', 'length_url', 'dot_count', 'has_insecure_key_words'
    ])
    print(attributes_df)
    return pd.concat([df, attributes_df], axis=1)

def load_data(filepath):
    return pd.read_csv(filepath)

def train_model(df):
    df_attributes = prepare_data(df)
    X = df_attributes[['has_https', 'has_http', 'tld_com', 'tld_com_br', 'tld_net', 'tld_org', 'tld_io', 'tld_gov', 'tld_edu', 'length_url', 'dot_count', 'has_insecure_key_words']]
    y = df_attributes['label']
    
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)
    
    model_rf = RandomForestClassifier(n_estimators=101, random_state=42)
    model_rf.fit(X_train, y_train)
    
    y_pred = model_rf.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Random Forest Accuracy: {accuracy:.2f}")
    
    return model_rf

def predict_url(model, url):
    attributes = verify_url_ml(url)
    attribute_df = pd.DataFrame([attributes], columns=[
        'has_https', 'has_http', 'tld_com', 'tld_com_br', 'tld_net', 'tld_org', 'tld_io', 
        'tld_gov', 'tld_edu', 'length_url', 'dot_count', 'has_insecure_key_words'
    ])
    
    prediction = model.predict(attribute_df)
    return "maliciosa" if prediction[0] == 1 else "segura"

csv_file_path = os.path.join(os.path.dirname(__file__),'example_urls.csv')
data = load_data(csv_file_path)
model = train_model(data)

joblib.dump(model, 'random_forest.pkl')