import { useEffect, useMemo, useState } from 'react';
import {
  Button,
  ImageButton,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import { useFuzzySearch } from 'tgui-core/fuzzysearch';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { logger } from '../../logging';

type BuildModeData = {
  current_category: number;
  selected_item: string | null;
  pixel_positioning: boolean;
  build_dir: number;
  categories: BuildModeCategory[];
};

type BuildModeCategory = {
  id: number;
  name: string;
  items: BuildModeItem[];
};

type BuildModeItem = {
  path: string;
  name: string;
  icon: string;
};

const CATEGORY_NAMES: Record<number, string> = {
  1: 'Turfs',
  2: 'Objects',
  3: 'Mobs',
  4: 'Items',
  5: 'Weapons',
  6: 'Clothing',
  7: 'Food',
  8: 'Liquid Vessels',
};

export function BuildMode() {
  const { act, data } = useBackend<BuildModeData>();
  const { current_category, selected_item, pixel_positioning, categories } =
    data;

  // Get items for the current category from static data
  const currentItems = useMemo(() => {
    const cat = categories.find((c) => c.id === current_category);
    return cat?.items || [];
  }, [categories, current_category]);

  const { query, setQuery, results } = useFuzzySearch({
    searchArray: currentItems,
    matchStrategy: 'smart',
    getSearchString: (item: BuildModeItem) => {
      return `${item.path} ${item.name || ''}`;
    },
  });

  // Show filtered results when searching, all items when empty
  const displayItems =
    query === '' ? currentItems : results;

  return (
    <Window height={600} title="Build Mode" width={700}>
      <Window.Content>
        <Stack vertical fill>
          {/* Category tabs */}
          <Stack.Item>
            <Tabs>
              {categories.map((cat) => (
                <Tabs.Tab
                  key={cat.id}
                  selected={current_category === cat.id}
                  onClick={() =>
                    act('select_category', { category: cat.id })
                  }
                >
                  {cat.name}
                </Tabs.Tab>
              ))}
            </Tabs>
          </Stack.Item>

          {/* Search + controls */}
          <Stack.Item>
            <Section>
              <Stack>
                <Stack.Item grow>
                  <Input
                    placeholder={`Search ${CATEGORY_NAMES[current_category] || 'items'}...`}
                    value={query}
                    onChange={(value) => setQuery(value)}
                    fluid
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="crosshairs"
                    selected={pixel_positioning}
                    tooltip="Toggle pixel positioning mode"
                    onClick={() => act('toggle_pixel')}
                  >
                    Pixel
                  </Button>
                </Stack.Item>
                {selected_item && (
                  <Stack.Item>
                    <Button
                      icon="times"
                      color="bad"
                      tooltip="Clear selection"
                      onClick={() => act('clear_selection')}
                    >
                      Clear
                    </Button>
                  </Stack.Item>
                )}
              </Stack>
            </Section>
          </Stack.Item>

          {/* Selected item preview */}
          {selected_item && (() => {
            const selItem = currentItems.find((i) => i.path === selected_item);
            if (!selItem) return null;
            return (
              <Stack.Item>
                <Section style={{ height: '4em' }}>
                  <Stack align="center">
                    <Stack.Item>
                      <ImageButton
                        asset={['buildmode32x32', selItem.icon]}
                        imageSize={32}
                        selected
                      />
                    </Stack.Item>
                    <Stack.Item grow>
                      <Stack vertical>
                        <Stack.Item bold>{selItem.name}</Stack.Item>
                        <Stack.Item
                          italic
                          style={{ color: 'rgba(200, 200, 200, 0.7)' }}
                        >
                          {selItem.path}
                        </Stack.Item>
                      </Stack>
                    </Stack.Item>
                  </Stack>
                </Section>
              </Stack.Item>
            );
          })()}

          {/* Item grid */}
          <Stack.Item grow>
            <Section fill scrollable>
              {displayItems.length === 0 ? (
                <NoticeBox textAlign="center" color="blue" width="100%">
                  {query === ''
                    ? `No items in this category`
                    : 'Nothing found'}
                </NoticeBox>
              ) : (
                <Stack wrap>
                  {displayItems.map((item, index) => (
                    <Stack.Item key={item.path} mb={0.5}>
                      <ImageButton
                        asset={['buildmode32x32', item.icon]}
                        imageSize={32}
                        selected={selected_item === item.path}
                        color="transparent"
                        tooltip={item.name}
                        tooltipPosition="bottom"
                        onClick={() => act('select_item', { path: item.path })}
                      />
                    </Stack.Item>
                  ))}
                </Stack>
              )}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}
