import { User } from './User';
import { Brand } from './Brand';
import { Country } from './Country';
import { SubType } from './SubType';

export class Inventory {
    id: number;
    name: string;
    brand: Brand;
    user: User;
    country: Country;
    sub_type: SubType;
    volume: number;
    year: number;
    price: number;
    quantity: number;
    submitted: Date;
    description: string;
    imageUrl: string;

    constructor() {
      this.id = null;
      this.name = null;
      this.brand = null;
      this.user = null;
      this.country = null;
      this.sub_type = null;
      this.volume = null;
      this.year = null;
      this.price = null;
      this.quantity = null;
      this.submitted = null;
      this.description = null;
      this.imageUrl = null;
    }
  }
