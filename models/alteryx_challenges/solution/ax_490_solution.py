import pandas as pd

def model(dbt, session):

    dbt.config(
        materialized="table"
        , packages=['pandas']
    )

    df = dbt.ref('stg_ax__490').to_pandas()
    
    df_source = dbt.ref('stg_ax__490_raw').to_pandas()
    
    flag_list = []

    while True:

        df_merged = df.merge(df_source, left_on=['NEXT', 'AMOUNT'], right_on =['Sender_Account_ID','Amount_of_Transaction'])

        if len(df_merged) == 0:
            break

        df_merged = df_merged[df_merged['DATE'] < df_merged['Transaction_Date']]
        
        flagged_transaction = df_merged[df_merged['ORIGIN'] == df_merged['Receiver_Account_ID']]
        
        flag_list.append(flagged_transaction)  # compile

        df_merged = df_merged[df_merged['ORIGIN'] != df_merged['Receiver_Account_ID']]
        
        df_merged = df_merged[['ORIGIN', 'Sender_Account_ID', 'Receiver_Account_ID', 'AMOUNT', 'Transaction_Date']]

        df_merged = df_merged.rename(columns = {'Sender_Account_ID' : 'Current',
            'Receiver_Account_ID' : 'NEXT', 'Transaction_Date' : 'DATE'})

        df = df_merged.copy() # loop

    return pd.concat(flag_list)
