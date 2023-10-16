import { LightningElement, api } from 'lwc';

export default class RecordList extends LightningElement {

    @api rec;
    @api iconName = 'standard:event';

    handleSelect(){
        let selectService = new CustomEvent ('select', {
            detail: {
                selRec : this.rec
            }
        });
        this.dispatchEvent(selectService);
    }

    handleRemove(){
        let selectService = new CustomEvent('select',{
            detail: {
                selRec : undefined
            }
        });
        this.dispatchEvent(selectService);
    }

}


















