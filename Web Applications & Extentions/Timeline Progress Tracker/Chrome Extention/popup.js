const TIMEZONE = "Africa/Cairo";

function getCairoNow() {
    return new Date(new Date().toLocaleString("en-US", { timeZone: TIMEZONE }));
}

function formatCountdown(value, unit) {
    const rtf = new Intl.RelativeTimeFormat("en", { numeric: "auto" });
    return value < 0 
        ? `<span class='passed'>${rtf.format(value, unit)}</span>` 
        : rtf.format(value, unit);
}

function getCairoDate(year, month, day) {
    return new Date(new Date(Date.UTC(year, month - 1, day)).toLocaleString("en-US", { timeZone: TIMEZONE }));
}

const startDate = getCairoDate(2025, 2, 8);
const midtermDate = getCairoDate(2025, 4, 5);
const finalDate = getCairoDate(2025, 5, 24);

function updateProgress(elementId, current, total) {
    const progress = Math.max(0, Math.min(100, (current / total) * 100));
    document.getElementById(elementId).style.width = `${progress}%`;
}

function updateCounts() {
    const cairoNow = getCairoNow();

    // Update today's date display
    const formatter = new Intl.DateTimeFormat("en-US", {
        weekday: "long", year: "numeric", month: "long", day: "numeric", timeZone: TIMEZONE
    });
    document.getElementById("today").textContent = formatter.format(cairoNow);

    // Update timezone indicator
    document.querySelector(".timezone-indicator").textContent = 
        `(${Intl.DateTimeFormat('en-US', { timeZone: TIMEZONE, timeZoneName: 'short' }).format(cairoNow)})`;

    // Calculate term week and progress
    let daysSinceStart = Math.floor((cairoNow - startDate) / (1000 * 60 * 60 * 24));
    let termWeekText = "Pre-Term";
    let weekTypeText = "";

    if (daysSinceStart >= 0) {
        const termWeek = Math.floor(daysSinceStart / 7) + 1;
        termWeekText = `Week ${Math.max(termWeek, 1)}`;
        weekTypeText = termWeek % 2 === 0 ? "(Even)" : "(Odd)";
        
        // Update week progress
        const daysIntoWeek = daysSinceStart % 7;
        updateProgress("weekProgress", daysIntoWeek + 1, 7);
    }

    document.getElementById("termWeek").textContent = termWeekText;
    document.getElementById("weekType").textContent = weekTypeText;

    // Update countdown and progress bars
    function updateCountdown(targetDate, daysElementId, weeksElementId, progressId) {
        const totalDays = Math.ceil((targetDate - startDate) / (1000 * 60 * 60 * 24));
        const daysRemaining = Math.ceil((targetDate - cairoNow) / (1000 * 60 * 60 * 24));
        const daysPassed = totalDays - daysRemaining;
        
        document.getElementById(daysElementId).innerHTML = formatCountdown(daysRemaining, "day");
        document.getElementById(weeksElementId).innerHTML = formatCountdown(Math.ceil(daysRemaining / 7), "week");
        updateProgress(progressId, daysPassed, totalDays);
    }

    updateCountdown(midtermDate, "midtermDays", "midtermWeeks", "midtermProgress");
    updateCountdown(finalDate, "finalDays", "finalWeeks", "finalProgress");
}

// Update every minute to keep progress bars current
setInterval(updateCounts, 60000);
updateCounts(); // Initial update
