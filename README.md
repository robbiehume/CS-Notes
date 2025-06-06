# CS-Notes

### [Wiki notes link](https://github.com/robbiehume/CS-Notes/wiki)

## GitHub Wiki tips
* HTML tab space: 
    * Regular space: `&nbsp;`
    * Two spaces gap: `&ensp;`
    * Four spaces gap: `&emsp;`
* Add line: `<br/>` 
* Search for wiki containing a specific word: `repo:robbiehume/CS-Notes <word>`; then click on the **Wikis** tab
* Crop an image: `<img src="image_link" width="400">`
* Put a single back tick in code format block: `` ` ``
* Cleaner arrow than `-->`: `→`
* Markdown table text alignment (line under headers):
  * `:---` : The colon on the left side indicates that the content in that column should be left-aligned.
  * `---:`: A colon on the right side indicates right-alignment.
  * `:---:`: Colons on both sides indicate center-alignment.
  * `---`: No colons usually defaults to left-alignment, but can sometimes vary depending on the Markdown renderer.

* Side by side code table template:
    * <table><tr>
          <th>app.js</th>
          <th>index.html</th>
      </tr><tr><td>

      ```javascript 
      <JS code>
      ```
      </td><td>

      ```html 
      <HTML code>
      ```
      </td></tr></table>

* Collapsable div: [link](https://gist.github.com/pierrejoubert73/902cc94d79424356a8d20be2b382e1ab)
  * Example used in [AWS Notes](https://github.com/robbiehume/CS-Notes/wiki/AWS) at top of page, and [Java Notes](https://github.com/robbiehume/CS-Notes/wiki/Java#-strings-)
  * To start with it opened, do `<details open="">`
  * To add header styling, put the summary content in a header tag. Ex:
     *  ```html
        <details>
          <summary><h4>Header title (Click me)</h4></summary>
          Content
        </details>
        ```
  
## Misc. tips
* To look through a wiki contents inside collapsable sections, search through the edit page
* Could create markdown pages in the repo and link to them from the wiki pages 
  * Can also add sample code into the repo
* Open all closed `<details>` sections:
  * ```js
    document.querySelectorAll('details').forEach(details => details.open = true);
    ```
