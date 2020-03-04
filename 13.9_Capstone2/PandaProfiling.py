PATH = "C:\\Users\\Kenei\\OneDrive\\Documents\\GitHub\\Thinkful\\Data\\Airbnb\\Seattle_20191121_listings.csv"

import pandas as pd
import pandas_profiling
data_SeattleAirbnb = pd.read_csv(PATH)
profile = data_SeattleAirbnb.profile_report(title='Pandas Profiling Report')
profile.to_file(output_file="SeattleAirbnb_pandas_profiling.html")