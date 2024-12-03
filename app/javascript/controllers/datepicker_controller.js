import { Controller } from "stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      dateFormat: "Y-m-d", // Date format
      minDate: "today",    // Prevent selection of past dates
      allowInput: true     // Allow users to type the date as well
    })
  }
}
