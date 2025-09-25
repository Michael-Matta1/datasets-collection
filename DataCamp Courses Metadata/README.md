# DataCamp Courses Metadata Dataset

**Access the complete dataset on Kaggle**: [DataCamp Courses Metadata](https://www.kaggle.com/datasets/michaelmatta0/datacamp-courses-metadata/data)

## Files Overview

### 📚 `courses.csv` (Main Dataset)
Contains detailed metadata for completed courses on DataCamp. This includes 23 columns covering:
- **Course basics**: title, description, programming language, difficulty level
- **Learning metrics**: XP points, estimated time, chapters, exercises, videos
- **Categorization**: topic and technology IDs, content areas
- **Engagement data**: subscription numbers, last update dates
- **Educational structure**: instructors, collaborators, prerequisites, associated tracks

### 🛤️ `all_tracks.csv` (Learning Tracks)
Aggregated information about DataCamp learning tracks (career tracks and skill tracks) with 18 columns including:
- Track metadata and career classification
- Aggregated course statistics (total chapters, exercises, videos)
- Learning metrics (total XP, time requirements)
- Content analysis (programming languages, difficulty levels)
- Participation data and instructor information

### 🗺️ Mapping Files
- **`technology_mapping.csv`**: Maps technology IDs to human-readable technology names (Python, R, SQL, etc.)
- **`topic_mapping.csv`**: Maps topic IDs to subject areas (Data Manipulation, Machine Learning, etc.)

## 📈 Visualization & Analysis

**Explore the data with interactive visualizations**: [Learning Journey Visualization Notebook](https://www.kaggle.com/code/michaelmatta0/learning-journey-visualization/)

This Kaggle notebook provides comprehensive analysis and visualization of the dataset, including learning patterns, course structures, and progress tracking.

## Getting Your Own Data

Want to analyze your own DataCamp learning journey? You can:

1. **Download your completed course metadata** using my fork: [datacamp-downloader](https://github.com/Michael-Matta1/datacamp-downloader)
2. **Visualize your progress** with the [Learning Journey Visualization notebook](https://www.kaggle.com/code/michaelmatta0/learning-journey-visualization/) or create your own analysis
3. **Create an AI tutor** from your materials using my [DataCompanion RAG](https://github.com/Michael-Matta1/datacompanion-rag-tutor) to chat with your completed courses

## Use Cases
- **Learning Analytics**: Track progress patterns and course completion strategies
- **Content Analysis**: Understand course structures and educational design
- **Skill Development**: Map learning paths and identify knowledge gaps
- **Educational Research**: Study online learning behaviors and course effectiveness
- **Personal Development**: Optimize your own learning journey based on data insights

## Notes

### Data Quality
> **Note:**  
> The dataset has undergone a multi-step collection process, including **scraping, extraction, transformation, and merging**. While careful effort was made to ensure accuracy and consistency, there may still be some **minor errors or inconsistencies** due to the complexity of the process.  
>  
> Additionally, some data is inherently **less precise as originally assigned by DataCamp** and was extracted in that form. For example, a course that primarily covers **PyTorch** may still have its technology listed more broadly as **Python**, which is the case I discovered for one course in my own completed courses.

### Customization
> **Note:**  
> The **topics, technologies, and programming languages** included in the dataset are based on the **standard categorizations defined by DataCamp**. However, you are free to **customize or extend** them by adding your own categories, tags, or groupings according to what best suits your analysis or learning objectives.

You can find examples of data cleaning and customization in the [Learning Journey Visualization notebook](https://www.kaggle.com/code/michaelmatta0/learning-journey-visualization/).