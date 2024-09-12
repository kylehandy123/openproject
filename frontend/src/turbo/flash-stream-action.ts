import { StreamActions, StreamElement } from '@hotwired/turbo';

export function registerFlashStreamAction() {
  StreamActions.flash = function dialogStreamAction(this:StreamElement) {
    const template = this.templateElement.content;
    // debugger;
    const content = document.getElementById('flash-container') || document.body;
    content.append(template);
  };
}
