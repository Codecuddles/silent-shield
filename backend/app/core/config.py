from dotenv import load_dotenv
import os

load_dotenv()

class Settings:
    APP_NAME = "Silent Shield"
    DATABASE_URL = os.getenv(
        "DATABASE_URL",
        "mysql+pymysql://root:@localhost/silent_shield"
    )
    SECRET_KEY = os.getenv("SECRET_KEY", "supersecretkey")
    ALGORITHM = "HS256"

settings = Settings()

