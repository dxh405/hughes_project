## Montage of a Dream Deferred Review


* Site publication: <https://dxh405.github.io/hughes_project/>
* GitHub: <https://github.com/dxh405/hughes_project>
* Developers: Barbie Cessar, Jacqueline Chan, Daniel Hough, Aidan Olsen, Amaya Willis
* Date of Evaluation: 2020-12-24
* Evaluated by: @ebeshero

### General
This team helped to improve what's available for reading Langston Hughes on the Worldwide Web. Before what you could find of *Montage of a Dream Deferred* was an image-based PDF, the one you started with, and what we have now is easier to read and search. Each of you took care in preparing your XML representing different portions of this poetry collection and you were responsible curators of this digital edition. Congratulations on a successful team project! There are aspects of the web display that are a little rough, as we expect for something developed in about a month. I’m commenting here on things to polish the edition as a web resource, with the hope that you may want to see this as a serious public-facing production to be read and appreciated not just by your peers and professors at Penn State Behrend but by people who find their way to Langston Hughes over the webs, people who want to read or teach or write about Langston Hughes. Your project is real, and what you (some of you, one or two of you, or all of you) can do now is revise it to make it look less like a student project submitted for a class and more obviously a professional project that you could share at a conference or on a job application as evidence of polished, careful work.

### Digital Document Curation and Research Questions
On your “About the Project” page you help introduce first Langston Hughes, and then this collection of poems. Try reorganizing this a little: The most interesting paragraph on this page is actually about the poem collection itself:

```
This project centers around a collection of poems written by Langston Hughes called "Montage of a Dream Deferred."
This book-length collection of poems was originally published in 1951. The poems are considered to be written in 
"jazz style" and focuses on descriptions of Harlem and its mostly African-American inhabitants. This collection was Hughes'
first major publication following the end of World War II. The themes of the poems centered around the racial inequality
that African-Americans experienced and the many different ways it showed itself.
```
I think  you should **lead** with this paragraph, and then put the more general bio paragraph about Hughes below that. (You should italicize the collection title, *Montage of a Dream Deferred* because it is book-length, a large work.) You might want to add a little something to discuss how your web edition of this collection is foregrounding the title motifs of “dream,” “dream deferred,” and “montage of a dream deferred.” (What's a *montage* by the way, and why does that word fit the collection you have represented here?)

I'd suggest moving the discussion of your project team work into its own area. Try organizing this page with three headings:
* About the Poems (lead paragraph about Montage collection)
* About Langston Hughes (Hughes's bio paragraph)
* About the Project (where you describe the work you did)

This helps keep the project focused on the Montage collection first and foremost. The rest is more "behind-the-scenes" material, about the writer and about *you* as the editors for this open source, open access publication of the poetry collection. 



### Correcting the site menu, thinking about copyright, and revisiting fonts
There's a problematic entry on the site menu, and that's the one pointing to an “Original Manuscript.” That is a serious problem because your source was not a manuscript at all. (A *manuscript* is a hand-written document, and while we worked with some manuscripts together as a class, you did not work with anything like that for the Montage project.) Instead what you worked with is an image-based PDF of the 1951 print publication of this poetry collection. You can change this heading just to “Source Document,” but you might also want to add some information about it to your paragraph about the poetry collection over on the about.html page. 

#### Langston Hughes and the public domain
Speaking of your source document, one question readers might have is whether the text is under copyright You might read more about that and comment on what you can see of the internet presence of this collection on the web. Check out the Langston Hughes’ wiki-source entry on the copyright status of his published work: https://en.wikisource.org/wiki/Author:James_Mercer_Langston_Hughes#Copyright , and you can follow the leads at the bottom of the page to learn more about public domain in the US. Under the Berne convention, this is public domain because Hughes died in 1967 and copyright covers his work up to 50 years after this death, meaning it would have expired in 2017. Also, here is a site that specifically reinforces that interpretation, indicating that Langston Hughes’ work entered the public domain on 1 January 2018: <https://qz.com/quartzy/1161701/public-domain-works-and-images-in-2018-che-guevara-langston-hughes-john-coltrane-rene-magritte-alice-b-toklas/>. It is also worth describing the PDF source circulated on the public web and indicate that you worked on this in context of a course, for nonprofit educational purposes. 
discuss how your work improves on this as a reading resource. 

#### Fonts
You were very careful in choosing your fonts for the project for headings and body text of the reading view in particular. consider changing the fonts for the rest of the website to match what you're using in the reading view, so you have a more consistent style. Especially since you chose that amazing serifed font for the website banner, it makes sense to stick with that font. Using the same body font throughout all the pages will make your styling more evidently deliberate and professional.

### “Our Codes” page
The page titled “Our Codes” lists out some links to your code without much explanation of what they are for. This is one area of your site that can really use more care for documenting your work, since one subset of your readership will be student coders and people learning about XML “stack” technology as well as digital curation. You want to be telling us more about some of your coding decisions: Remember how you discussed coding the poems, and what information you really wanted to capture? Talk about that. Try writing some paragraphs featuring key decisions and turning points in the project.

One of the best examples I know for writing a good "coding methodology" page was written up by some of my former students on the Emily Dickinson project team: <http://dickinson.newtfire.org/methodology.html>
Now, that project went on over two semesters and took on an afterlife of its own (one of the student developers, Nicole Lottig, has since graduated but still works on this project and wants to expand it to cover all of Dickinson’s poetry!) You wouldn't have *nearly* this much to write, but you could write something in a similar style that helps orients your readers to what you did to model the poems in code and represent them with care in this digital edition. I know that takes time and you were short on that at the end of the semester, but you can add more now—as an investment in sharing this project again down the road perhaps at a conference or at our campus DIGIT fest (coming up this spring). 

### Layout and HTML code repairs
All(?) or most of your HTML pages show this attribute `xmlns:xs="http://www.w3.org/2001/XMLSchema"` in the root HTML element:
```
<html xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml">
```
The attribute does not belong there, and I am not sure where it originated, because it's really just something you need for XSLT and should not turn up in any of the HTML. Maybe you copied it into the root element of the HTML files that you hand-wrote maybe thinking that you needed it, but it is making your HTML output invalid. Just go through and remove it wherever you see it now. (The [w3c validator flags that attribute as an outright error](https://validator.w3.org/nu/?doc=https%3A%2F%2Fdxh405.github.io%2Fhughes_project%2Fabout.html) when I test your code there.

#### Layout issues on About the Team page
There are some pretty serious layout problems with the display of the team members. We see a large gap between a row of images and text descriptions associated with them. You may be tempted to try to fix this by adjusting the css for the .image1 class, but the problem runs deeper, to do with trying to organize the layout of this page based on an HTML table. You don't want to do that for reasons of web accessibility (read more about why NOT to use HTML tables to layout images and text together: <https://www.lifewire.com/dont-use-tables-for-layout-3468941>). You really only want to use tables for holding data and information together in a related way, as in a table of poems and line-counts, for example. To professionalize this page and make it simple and accessible, find a different strategy for associating text and image. For example, you could use `<div>` elements to contain an image and its caption of information about each team member.You could wrap these in a section that you style using CSS flex containers (see <https://www.w3schools.com/css/css3_flexbox.asp> ).  

### Closing Comments
Your team did a marvelous job of launching what appears to be the first serious, searchable *digital edition* of Langston Hughes's Montage collection since Hughes' work entered the public domain in 2018! That is a serious accomplishment, and one that also means you as the curators deserve recognition of your fine work. Cleaning up the website layout and code issues is one way to honor your work for posterity and not just something you did for a class. You have done the hard work of document curation already, and the rest is showing that you have a professional interest in the posterity of the site. So I hope a few of you will be interested in revising to polish this very important work you launched together! 
