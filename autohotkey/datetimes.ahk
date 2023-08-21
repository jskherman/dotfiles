#Requires AutoHotkey v2.0

/* Variables */
days_lived := DateDiff(A_Now, 20010529, "D")
reviewdays_left := DateDiff(20231125, A_Now, "D")

/* The Days */ 
::day;;:: {
    ; Days lived so far
    SendInput days_lived
}

::lday;;:: {
    ; Days remaining for review
    SendInput reviewdays_left
}

::rday;;:: {
    ; Days remaining for review
    SendInput Format("{1:02}", 100 - reviewdays_left)
}

::today;;:: {
    ; Today's date as YYYY-MM-DD
    SendInput FormatTime(, "yyyy-MM-dd")
}

; Time
::dt;;:: {
    ; Current time as `HH:mm`
    SendInput Format("``{1}``", FormatTime(, "HH:mm"))
}

::ft;;:: {
    ; Current time as `HH:mm`
    SendInput Format("=={1}==", FormatTime(, "HH:mm"))
}

::mt;;:: {
    ; Current time as `HH:mm`
    SendInput Format("{1}H", FormatTime(, "HHmm"))
}

/* Timestamps */
::tid;;:: {
    ; Timestamp ID (YYYYMMDDHHmmss)
    SendInput A_Now
}

::iso;;::
::ts;;:: {
    ; ISO 8601 timestamp
    SendInput FormatTime(, "yyyy-MM-ddTHH:mm:ss")
}

::uts;;::
::unixts;;:: {
    ; Unix timestamp (seconds)
    SendInput DateDiff(A_NowUTC, 19700101000000, "S")
}