# Timeline Progress Tracker

**Timeline Progress Tracker** s a web-based tool designed to help students track their academic term progress. It provides a visual representation of the current week, time remaining until midterms and finals, and a progress bar to show how much of the term has been completed. The tool is designed with a clean, modern interface and supports both light and dark themes. By default, it is configured to update according to the Cairo timezone, but users can change this setting if needed.

---
## Main Version

The primary and most up-to-date version of the project is located in the `index.html` file.

---
## Features

* **Today's Date**: Displays the current date in Cairo time
* **Term Week Tracker**: Shows the current week of the term and whether it's an odd or even week
* **Midterm Countdown**: Tracks the number of days and weeks remaining until the midterm date
* **Final Exam Countdown**: Tracks the number of days and weeks remaining until the final exam date
* **Progress Bars**: Visual progress bars for the current week, midterm, and final exam
* **Theme Toggle**: Switch between light and dark themes with a single click
* **Responsive Design**: Works seamlessly on both desktop and mobile devices
* **Real-time Updates**: Tracks dates and countdown timers in real-time
* **Timezone Aware**: All times are displayed in Cairo timezone
* **Accessibility**: Keyboard navigation support and ARIA-compliant

## How to Use
**Interaction with the Tool**:
   - The tool will automatically display the current date, term week, and countdowns to midterms and finals
   - Use the theme toggle button (🌓) in the top-right corner to switch between light and dark themes

## Configuration and Customization

### Changing Dates
To customize the term start date, midterm date, or final exam date, modify the following lines in the `<script>` section of the `index.html` file:
```javascript
const startDate = getCairoDate(2025, 2, 8); // Term start date (YYYY, MM, DD)
const midtermDate = getCairoDate(2025, 4, 5); // Midterm date (YYYY, MM, DD)
const finalDate = getCairoDate(2025, 5, 24); // Final exam date (YYYY, MM, DD)
```

### Changing Timezone
To change the timezone, update the `TIMEZONE` constant in the `<script>` section:
```javascript
const TIMEZONE = "Africa/Cairo"; // Replace with your desired timezone
```

### Theme Customization
The application uses CSS variables for easy theme customization. You can modify the colors and styles by updating the variables in the `:root` selector:
```css
:root {
    --primary-color: #4CAF50;
    --accent-color: #FFD700;
    --bg-gradient: linear-gradient(-45deg, #1a1a1a, #121212, #1a1a1a, #121212);
    /* ... other variables ... */
}
```

## Technical Details

* Pure HTML, CSS, and JavaScript implementation
* No external dependencies required
* Uses modern JavaScript features including:
  * Intl.RelativeTimeFormat for natural language time differences
  * CSS Grid and Flexbox for layout
  * CSS Variables for theming
  * Intersection Observer API for scroll animations

## Browser Support

The application supports all modern browsers including:
* Chrome (latest)
* Firefox (latest)
* Safari (latest)
* Edge (latest)

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

1. Fork the repository
2. Create a new branch for your feature or bugfix: `git checkout -b feature/AmazingFeature`
3. Make your changes and commit them: `git commit -m 'Add some AmazingFeature'`
4. Push your changes to your fork: `git push origin feature/AmazingFeature`
5. Submit a pull request to the main repository


## License

This project is licensed under the MIT License.

