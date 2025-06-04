#!/usr/bin/env python
# coding: utf-8

# In[3]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
get_ipython().run_line_magic('matplotlib', 'inline')


# In[4]:


df = pd.read_csv("F:\Data_Set_WT.csv") 
df.head()


# In[7]:


df.info()
df.describe()
df.shape
df.columns


# In[9]:


df.describe()


# In[11]:


df.isnull().sum()
df = df.dropna()
df


# In[13]:


df.isnull().sum()


# In[15]:


df['date'] = pd.to_datetime(df['date'])


# In[17]:


df['Failure_status'].value_counts().plot(kind='bar', title="Failure vs No Failure")
plt.xlabel('Status')
plt.ylabel('Count')
plt.show()


# In[18]:


features = ['Wind_speed', 'Power', 'Generator_bearing_temperature', 'Rotor_Speed', 'Yaw_angle']
for col in features:
    plt.figure(figsize=(6,4))
    sns.histplot(df[col], kde=True)
    plt.title(f'Distribution of {col}')
    plt.show()
    


# In[20]:


for col in features:
    plt.figure(figsize=(6,4))
    sns.boxplot(x=df[col])
    plt.title(f'Boxplot of {col}')
    plt.show()


# In[21]:


df


# In[22]:


df
df.columns


# In[24]:


get_ipython().run_line_magic('run', 'windturbine.ipynb')


# In[ ]:


sensor_cols = ['Wind_speed', 'Power', 'Nacelle_ambient_temperature',
       'Generator_bearing_temperature', 'Gear_oil_temperature',
       'Ambient_temperature', 'Rotor_Speed', 'Nacelle_temperature',
       'Bearing_temperature)', 'Generator_speed', 'Yaw_angle',
       'Wind_direction', 'Wheel_hub_temperature', 'Gear_box_inlet_temperature']

for col in sensor_cols:
    df2= df.groupby('Failure_status')[col].describe()
    


# In[ ]:


df2


# In[ ]:


df


# In[ ]:


df['Failure_status'].value_counts()


# In[ ]:


Vari = ['Wind_speed', 'Power', 'Nacelle_ambient_temperature',
       'Generator_bearing_temperature', 'Gear_oil_temperature',
       'Ambient_temperature', 'Rotor_Speed', 'Nacelle_temperature',
       'Bearing_temperature)', 'Generator_speed', 'Yaw_angle',
       'Wind_direction', 'Wheel_hub_temperature', 'Gear_box_inlet_temperature']
results = {}

for col in Vari:
    desc = df.groupby('Failure_status')[col].describe()
    desc['IQR'] = desc['75%'] - desc['25%']
    desc['lower'] = desc['25%'] - 1.5 * IQR
    desc['upper'] = desc['75%'] + 1.5 * IQR
    results[col] = desc

# To display all
for col, table in results.items():
    print(f"\n--- {col} ---\n")
    print(table)


# In[ ]:


# barplot for Failure vs Non-Failure Counts Within Non-Failure Ranges
data = {
    'Variable': [
        'Wind_speed', 'Power', 'Nacelle_ambient_temperature', 'Generator_bearing_temperature',
        'Gear_oil_temperature', 'Ambient_temperature', 'Rotor_Speed', 'Nacelle_temperature',
        'Bearing_temperature)', 'Generator_speed', 'Yaw_angle', 'Wind_direction',
        'Wheel_hub_temperature', 'Gear_box_inlet_temperature'
    ],
    'Failure_in_range': [600, 0, 227, 142, 33, 600, 764, 59, 939, 110, 0, 513, 817, 197],
    'No_failure_in_range': [2379, 2337, 2389, 2400, 2400, 2398, 2400, 2374, 2400, 2352, 2293, 2297, 2400, 2385]
}

df_plot = pd.DataFrame(data)

df_melted = df_plot.melt(id_vars='Variable', 
                         value_vars=['Failure_in_range', 'No_failure_in_range'],
                         var_name='Status', value_name='Count')

plt.figure(figsize=(16, 8))
sns.barplot(data=df_melted, x='Variable', y='Count', hue='Status')
plt.title('Failure vs Non-Failure Counts Within Non-Failure Ranges')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.show()


# In[ ]:


# % Difference between Nacelle_ambient_temperature and Failure status

df2= df.groupby('Failure_status')['Nacelle_ambient_temperature'].describe()
df2['IQR']= df2['75%']- df2['25%']

#now locating only no failure and range of percentiles
no_failure_q25= df2.loc['No_failure', '25%']
no_failure_q75= df2.loc['No_failure', '75%']

# Finding rang between 25% and 75% for Rotor speed
ranges_df = df[(df['Nacelle_ambient_temperature']> no_failure_q25) & (df['Nacelle_ambient_temperature'] < no_failure_q75)]
print(f"Failure and Nonfailure count of Non Failure {'Nacelle_ambient_temperature'} ranges:")
print(f"  Failure in range: {no_failure_q25}")
print(f"  Non-Failure in range: {no_failure_q75}")
print("-" * 40)


# In[ ]:


df_cleaned = df.copy()


# In[ ]:


df_cleaned.to_csv("Cleaned_WindTurbine.csv", index=False)


# In[ ]:




