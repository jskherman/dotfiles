#Requires AutoHotkey v2.0

/* Variables */
days_lived := DateDiff(A_Now, 20010529, "D")

/* The Days */
::day;;:: {
    ; Days lived so far
    SendInput days_lived
    return
}

:*:daily;;:: {
    today := FormatTime(A_Now, "yyyy-MM-dd | ddd")
    days_lived := DateDiff(A_Now, 20010529, "D")
    SendText Format("### {1}", today)
    Send "{Enter}{Enter}"
    SendText Format("- ``{1}`` This is ``Day #{2:05}`` of my existence.", FormatTime(, "HH:mm"), days_lived)
}


::today;;:: {
    ; Today's date as YYYY-MM-DD
    SendInput FormatTime(, "yyyy-MM-dd")
    return
}

; Time
:*:dtt::
:*:dt;;:: {
    ; Current time as `HH:mm`
    SendInput Format("``{1}``", FormatTime(, "HH:mm"))
    return
}

:*:ft;;:: {
    ; Current time as `HH:mm`
    SendInput ("\code{{}" Format("{1}", FormatTime(, "HH:mm")) "{}}")
    return
}

:*:mt;;:: {
    ; Current time as `HH:mm`
    SendInput Format("{1}H", FormatTime(, "HHmm"))
    return
}

/* Timestamps */
:*:tid;;:: {
    ; Timestamp ID (YYYYMMDDHHmmss)
    SendInput A_Now
    return
}

:*:iso;;::
:*:ts;;:: {
    ; ISO 8601 timestamp
    SendInput FormatTime(, "yyyy-MM-ddTHH:mm:ss")
    return
}

:*:uts;;::
:*:unix;;::
:*:unixts;;:: {
    ; Unix timestamp (seconds)
    SendInput DateDiff(A_NowUTC, 19700101000000, "S")
    return
}