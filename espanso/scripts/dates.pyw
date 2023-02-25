import sys
from datetime import date, datetime


def calc_days_lived():
    d0 = date(2001, 5, 29)
    d1 = date.today()
    delta = d1 - d0
    print(delta.days)


def ordinal_day():
    day = int(datetime.now().strftime("%d"))
    if 4 <= day <= 20 or 24 <= day <= 30:
        suffix = "th"
    else:
        suffix = ["st", "nd", "rd"][day % 10 - 1]

    print(str(day) + suffix)


if __name__ == "__main__":
    if len(sys.argv) == 3:
        globals()[sys.argv[1]](sys.argv[2])
    elif len(sys.argv) == 2:
        globals()[sys.argv[1]]()
