import { createDropdownInput, type Feature } from '../base';

export const directional_attack: Feature<number> = {
  name: 'Directional attack',
  category: 'GAMEPLAY',
  description:
    'Directional attacks let you hit a target by clicking past it, as long as it is within melee range.',
  component: createDropdownInput({
    2: 'Enabled',
    1: 'Only against simple mobs',
    0: 'Disabled',
  }),
};
