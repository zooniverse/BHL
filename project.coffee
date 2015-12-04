Rectangle = require './drawing-tools/rectangle'
Pinpoint = require './drawing-tools/pinpoint'
Details = require './tasks/details'
GroupsPage = require './groups'
team = require './content/team'
about = require './content/about'

group_page = new GroupsPage
teampage = require './templates/team-page'
subjectGroup = localStorage.getItem 'active-group'

[apiHost, apiProxyPath] = if window.location.hostname is 'www.sciencegossip.org'
  ['http://www.sciencegossip.org', '/_ouroboros_api/proxy']
else
  [null, null]

module.exports =
  id: 'illustratedlife'
  apiHost: apiHost
  apiProxyPath: apiProxyPath

  background: 'background.jpg'
  subjectGroup: subjectGroup ? 'random'
  groups: group_page.groups

  title: 'Science Gossip'
  summary: 'Uncover the history of citizen science'
  description: '''
                 In the Victorian period, just like today, scientists and members of the public worked together to further scientific discovery. Before computers and cameras they had to draw what they saw. Their drawings are locked away in the pages of Victorian periodicals, such as <cite>Science Gossip</cite>, <cite>Recreative Science</cite> and <cite>The Intellectual Observer</cite>. Help us to classify their drawings and map the origins of citizen science.
                 '''
  

  pages: [{
    key: 'periodicals'
    title: 'Periodicals'
    content: group_page
  },{
    key: 'about'
    title: 'About'
    content: [{
      key: 'science-gossip'
      title: 'Science Gossip'
      content: about
    },{
      key: 'the-team'
      title: 'The Team'
      content: teampage team
    }]
  }]
  
  externalLinks:
    Talk: 'http://talk.sciencegossip.org'
    Blog: 'http://blog.sciencegossip.org'
    '<i class="fa fa-twitter fa-lg">Twitter</i>': 'http://twitter.com/BioDivLibrary'

  tasks:
    illustrations:
      type: 'radio'
      question: 'Are there any illustrations on this page?'
      choices: [{
        label: 'Yes'
        value: 'yes'
        next: 'illustration'
      },{
        label: 'No'
        value: 'no'
      },{
        label: 'Skip this page'
        value: 'skip'
      }]
    illustration:
      type: 'drawing'
      question: 'Choose the type of illustration, then draw rectangles around each illustration of that type.'
      choices: [{
        type: Rectangle
        label: 'drawing/painting/diagram'
        value: 'drawing'
        color: '#006666'
        checked: true
      },{
        type: Rectangle
        label: 'chart/table'
        value: 'chart'
        color: '#666666'
      },{
        type: Rectangle
        label: 'photograph'
        value: 'photograph'
        color: '#660066'
      },{
        type: Rectangle
        label: 'map'
        value: 'map'
        color: '#666600'
      }]
      next: 'parts'
    details:
      type: 'details'
      question: 'Add keywords to describe each illustration.'
      choices: [{
        type: 'textarea'
        key: 'keywords'
        label: 'Keywords'
        value: ''
        placeholder: 'bird; landscape; crab; forest; man; woman; apple; pottery; cemetery; skull; fossil; microscopic view; meteor, meteorological observations'
      }]
      next: 'review'
    parts: 
      type: 'drawing'
      question: 'Mark any species, inscriptions and contributors in the illustrations.'
      choices: [{
        type: Pinpoint
        label: 'Species'
        value: 'species'
        color: 'darkorange'
        checked: true
        details:[{
          type: 'text'
          key: 'subject'
          choices:[{
            value: ''
            key: 'common'
            label: 'Common Name'
          },{
            value: ''
            key: 'scientific'
            label: 'Scientific Name'
          }]
        }]
      },{
        type: Pinpoint
        label: 'Inscription'
        value: 'inscription'
        color: 'darkorange'
        details:[{
          type: 'textarea'
          key: 'inscription'
          choices:[{
            value: ''
            key: 'text'
            label: 'Text'
          }]
        }]
      },{
        type: Pinpoint
        label: 'Contributor'
        value: 'contributor'
        color: 'darkorange'
        details:[{
          type: 'text'
          key: 'name'
          choices:[{
            value: ''
            key: 'name'
            label: 'Name'
          }]
        },{
          type: 'select'
          key: 'role'
          choices:[{
            value: 'illustrator'
            key: 'role'
            label: 'Role'
            options: [
              'illustrator'
              'engraver'
              'lithographer'
              'printer'
              'photographer'
              'artist'
              'other'
            ]
          }]
        }]
      }]
      next: 'details'
    review:
      type: 'radio'
      confirmButtonLabel: 'Finish'
      question: "Use the 'Back' button to review your work, or click 'Finish' to move on to the next page."
      choices: []

  firstTask: 'illustrations'
  
  examples: require './content/examples'

  tutorialSteps: require './content/tutorial-steps'

