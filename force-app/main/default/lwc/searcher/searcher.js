import { LightningElement, api, track } from 'lwc';

export default class Searcher extends LightningElement {
    @track keyword;

    @api isRequired = 'false';
    @api cmpLabel = 'Search Course';
    @api showLabel = 'true';

    //Check the isRequired prop is true then set the prop to true

    renderedCallback(){
        if(this.isRequired === "true") {
            let picklistInfo = this.template.querySelector('lightning-input');
            picklistInfo.required = true;

            this.isRequired = "false";
        }
    }

    handleChange(event) {
        var keyword = event.target.value;

        if(keyword && keyword.length >= 2) {
            let searchService = new CustomEvent('search',{
                detail : {value:keyword}
            });
            this.dispatchEvent(searchService);
        }
    }
}