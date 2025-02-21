import React, { useState, useEffect } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Clock, Calendar, BookOpen, GraduationCap } from 'lucide-react';

const TermTimeline = () => {
  const [timeData, setTimeData] = useState({
    today: '',
    termWeek: '',
    weekType: '',
    midtermDays: { text: '', passed: false },
    midtermWeeks: { text: '', passed: false },
    finalDays: { text: '', passed: false },
    finalWeeks: { text: '', passed: false },
    timezone: ''
  });

  const TIMEZONE = "Africa/Cairo";

  const getCairoNow = () => {
    return new Date(new Date().toLocaleString("en-US", { timeZone: TIMEZONE }));
  };

  const formatCountdown = (value, unit) => {
    const rtf = new Intl.RelativeTimeFormat("en", { numeric: "auto" });
    return {
      text: rtf.format(value, unit),
      passed: value < 0
    };
  };

  const getCairoDate = (year, month, day) => {
    return new Date(new Date(Date.UTC(year, month - 1, day)).toLocaleString("en-US", { timeZone: TIMEZONE }));
  };

  const updateCounts = () => {
    const cairoNow = getCairoNow();
    const startDate = getCairoDate(2025, 2, 8);
    const midtermDate = getCairoDate(2025, 4, 5);
    const finalDate = getCairoDate(2025, 5, 24);

    const formatter = new Intl.DateTimeFormat("en-US", {
      weekday: "long",
      year: "numeric",
      month: "long",
      day: "numeric",
      timeZone: TIMEZONE
    });

    // Extract timezone abbreviation safely
    const timezoneParts = Intl.DateTimeFormat('en-US', {
      timeZone: TIMEZONE,
      timeZoneName: 'short'
    }).formatToParts(cairoNow);
    const timezone = timezoneParts.find(part => part.type === 'timeZoneName')?.value || 'CAT';

    const daysSinceStart = Math.floor((cairoNow - startDate) / (1000 * 60 * 60 * 24));
    let termWeek = "Pre-Term";
    let weekType = "";

    if (daysSinceStart >= 0) {
      const week = Math.floor(daysSinceStart / 7) + 1;
      termWeek = `Week ${Math.max(week, 1)}`;
      weekType = week % 2 === 0 ? "(Even)" : "(Odd)";
    }

    const midtermDays = Math.ceil((midtermDate - cairoNow) / (1000 * 60 * 60 * 24));
    const finalDays = Math.ceil((finalDate - cairoNow) / (1000 * 60 * 60 * 24));

    setTimeData({
      today: formatter.format(cairoNow),
      termWeek,
      weekType,
      timezone,
      midtermDays: formatCountdown(midtermDays, "day"),
      midtermWeeks: formatCountdown(Math.ceil(midtermDays / 7), "week"),
      finalDays: formatCountdown(finalDays, "day"),
      finalWeeks: formatCountdown(Math.ceil(finalDays / 7), "week")
    });
  };

  useEffect(() => {
    updateCounts();
    const interval = setInterval(updateCounts, 1000 * 60); // Update every minute
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 py-12 px-4">
      <div className="max-w-2xl mx-auto space-y-6">
        <Card className="bg-gray-800/50 backdrop-blur-lg border-gray-700 hover:shadow-lg hover:shadow-purple-500/10 transition-all duration-300">
          <CardContent className="p-6 flex items-center space-x-4">
            <Calendar className="w-8 h-8 text-purple-400" />
            <div className="flex-1">
              <h2 className="text-gray-400 text-sm font-medium">Today</h2>
              <p className="text-white text-xl font-bold">{timeData.today}</p>
              <p className="text-gray-500 text-xs">{timeData.timezone}</p>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-gray-800/50 backdrop-blur-lg border-gray-700 hover:shadow-lg hover:shadow-blue-500/10 transition-all duration-300">
          <CardContent className="p-6 flex items-center space-x-4">
            <Clock className="w-8 h-8 text-blue-400" />
            <div className="flex-1">
              <h2 className="text-gray-400 text-sm font-medium">Term Week</h2>
              <div className="flex items-center space-x-2">
                <p className="text-white text-xl font-bold">{timeData.termWeek}</p>
                <span className="text-yellow-400 text-sm">{timeData.weekType}</span>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-gray-800/50 backdrop-blur-lg border-gray-700 hover:shadow-lg hover:shadow-green-500/10 transition-all duration-300">
          <CardContent className="p-6 flex items-center space-x-4">
            <BookOpen className="w-8 h-8 text-green-400" />
            <div className="flex-1">
              <h2 className="text-gray-400 text-sm font-medium">Until Midterm (April 5, 2025)</h2>
              <p className={`text-xl font-bold ${timeData.midtermDays.passed ? 'text-red-400' : 'text-white'}`}>
                {timeData.midtermDays.text}
              </p>
              <p className="text-gray-400 text-sm">{timeData.midtermWeeks.text}</p>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-gray-800/50 backdrop-blur-lg border-gray-700 hover:shadow-lg hover:shadow-orange-500/10 transition-all duration-300">
          <CardContent className="p-6 flex items-center space-x-4">
            <GraduationCap className="w-8 h-8 text-orange-400" />
            <div className="flex-1">
              <h2 className="text-gray-400 text-sm font-medium">Until Final (May 24, 2025)</h2>
              <p className={`text-xl font-bold ${timeData.finalDays.passed ? 'text-red-400' : 'text-white'}`}>
                {timeData.finalDays.text}
              </p>
              <p className="text-gray-400 text-sm">{timeData.finalWeeks.text}</p>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default TermTimeline;
