set maxBatt to 80
set minBatt to 40
set critBatt to 20

set Cap to (do shell script "ioreg -b -w 0 -f -r -c AppleSmartBattery | grep ExternalConnected")
tell Cap to set {wallPower} to {last word of paragraph 1}

set Pct to (do shell script "pmset -g batt | grep -Eo \"\\d+%\" | cut -d% -f1") as number
if Pct ³ maxBatt and wallPower = "Yes" then
	display notification "Battery level has reached " & Pct & "%" with title "Battery Charged" sound name "Hero"
else if Pct > critBatt and Pct ² minBatt and wallPower = "No" then
	display notification "" & Pct & "% Battery Remaining, plug in soon." with title "Low Battery" sound name "Submarine"
else if Pct ² critBatt and wallPower = "No" then
	display notification "" & Pct & "% Battery, plug in now." with title "Critical Battery" sound name "Ping"
else
	return 0
end if